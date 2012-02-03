---
title: Traditional Mistakes in C Programming
author: Dave Wilkinson
tags: [programming, c, style, mistakes]
---

When you approach a procedural language from an object-oriented, (mostly) type-safe language such as Java, there are certain concepts that do not make the best translation. Of course, the main topic is that of pointers. Frankly, the memory model being exposed to you, unlike the memory abstractions of Java, is a daunting thing at first. It does not have to be!

## Pointers in Java
In Java, we have pointers. In the Java world, they are called references. However, they come with rules that stem from their role as referrers for *objects*. Since there exists a relationship among objects, the compiler can enforce rules that govern how such a pointer may be used or dereferenced. For instance, you cannot (typically) use a Scanner reference as though it were a FileReader reference. Such a thing would be disastrous as much as it is useless! If there is an is-a relationship created via inheritance, then such a pointer cast is possible. A BufferedFileReader can be used as a FileReader, for instance.

## Breaking the Rules
In Java, however, it is not completely safe. You can cast to Object and back. Why? Because, under a non-strict compilation, you can cast **to Object** and you can essentially treat any object as any other. Ponder about the implications and object tree that is built from this. Ouch. Java has since created **generics** to get around the need for such an exception. C on the other hand is fundamentally designed to work this way. Why? Because C is a systems language, it runs natively, and it is meant to manipulate the underlying memory model directly (no abstractions, no garbage collector, no virtual machine.)

## Memory Model
So, what is the underlying memory model? It's an array of bytes starting from 0x00000000 and going as far up as 0xFFFFFFFFFFFFFFFF on some systems. Each byte has an address, which is simply a number within the acceptable range of the machine. On a 32-bit addressable machine, that number is 32 bits wide, etc. Within this space are regions of memory dedicated to particular tasks. The regions that are common in an average program are the **code-space**, **data-space**, **readonly-space**, **stack-space**, and **heap-space**. There is also usually nothing allocated at 0x00000000 (NULL) so that using NULL will crash the program with an access violation.

The code-space is for code; data-space is for writable, preallocated data for the program; readonly-space as for read-only, preallocated data for the program; stack-space is the region designated for the stack; heap-space is designated for dynamic allocations. Now, the stack and heap are not preallocated, and as such can grow to any size. A common way to mitigate the two colliding is to virtualize the address space and have the stack grow down and the heap grow up.

Now, in C, you can manipulate both regions. To use the stack, just allocate variables. They will be placed on the activation frame, and thus be placed upon the stack. So, just as an example:

``` c
int x;
```

This will place x in the stack frame for the function. This means it will be different for concurrent or consecutive calls of the function.

``` c
static int x;
```

This will place x in the data region, meaning it is shared by all calls of the function.

``` c
struct node new_node;
```

If you define a struct, it will be on the stack as well. This means, once the function returns, the contents of the struct **are destroyed**.

## Mistake #1 - Using a dangling pointer

Ok. You have a pointer. You know it should point to some... stuff.

``` c
char* str;
strcpy(str, "Hello World");
```

Pointers are just variables, much like ints, shorts, or doubles. They store a particular value. Much like a reference in Java, they can be declared, yet not be useful. That is, they can point (refer) to nothing (null / NULL). When you declare a variable, it receives an undefined value in C. So, technically, the pointer above points... somewhere. It might point to your code. Or to a valid string elsewhere. Or absolutely, positively, freaking, nothing!

The strcpy function, much like any function that expects some data or a place to put data, expects that the pointer it receives actually refers to a buffer large enough to do the job at hand. It **cannot** allocate anything for you the way it stands. Why? Well, look at the strcpy function:

``` c
char* strcpy(char *dest, const char *source) {
  while(*source != '\0') {
    *dest = *source;
    source++;
    dest++;
  }
  *dest = '\0';
  return dest;
}
```

It takes a char pointer. Now, you pass it absolute garbage in the code above that calls strcpy, right? So, even if it wanted to, say, ignore the value you gave it and allocate it itself... it cannot tell you what that pointer is. It could return it, but that defeats the point of passing it in the first place. Typically, the responsibility to free allocated data is done in the same scope as the allocation itself. A function should never allocate for you and require you to explicitly delete it. Since the function requests a pointer, it expects the reference to be valid.

``` c
char* str = (char*)malloc(12);
strcpy(str, "Hello World");
free(str);
```

## Mistake #2 - Using a stack-allocated struct to change a global data structure

``` c
struct node* head;

void* my_bestfit_malloc(size_t amount) {
  if (head == NULL) {
    head = sbrk(amount + sizeof(struct node));

    // initialize head

    return head + 1;
  }

  // find best fit
  struct node best;
  best = *head;

  while (best.next != NULL) {
    // check best
    best = *best.next;
  }

  // update best
  best.free = 0;
  return (void*)best.next - best.size;
}
```

No no no no no! :) Here, the code has done a **deep copy** of the data in the data structure. This is good when you want to copy the data and preserve it before destroying the data in the global data structure. However, if you mutate the data in the copy, it will obviously not persist in the real thing. In this case, the highlighted line (best.free = 0;) will update the local copy and set it to allocated. The data structure itself will not see that. It might allocate this space again, which is pretty terrible!

What you want here is a **shallow copy** of the data. That is, don't copy the data... copy the value that indicates where the data lives. Which, of course, is a pointer. Always refer to the data via indirection so that when you mutate it, it updates both the copy you are reading and the global data structure at the same time. There is no excuse for this mistake. If you are doing this to avoid the -> syntax, I empathize, but that notation is common and should be used.

## Mistake #3 - Pointer Arithmetic

Ok. Pointer math is weird. Enough said.

Well, let's go over it. It's weird not difficult. A char* is a pointer to a character, which is a single byte. Pointer arithmetic is when I take a pointer variable and add an integer to it. For instance:

``` c
char* a = "hey";
char* foo = a;
foo = foo + 2;
printf("%c\n", *foo);
```

Alright. As you might expect, this will print out "y" on a line. Why? A string is an array of characters. An array is simply a pointer. foo initially points to the first character of the string ('h'). foo contains the address of that character in memory. For instance, it is probably something huge like 0x12345678 or something, which means it is the 305,419,896th byte in the memory space... that's not incredibly important. What is important is that it is just a number, like the one on my mailbox or the number on your house or apartment, that tells the machine where data should eventually go. Let's assume foo contains the value 56, so that the string starts at byte 56 in memory.

When I add 2 to foo, I push the address further in the address space. 56 becomes 58. Because the string is stored contiguously in memory, we are now looking at the third character in the string. Neat. Direct manipulation of memory is really powerful. It gives you full range of the memory space. That is, it is horribly unsafe. Which means... we can do things like the following:

``` c
char* a = "hey";
char* b = "you";
char* foo = a;
foo = foo + 5;
printf("%c\n", *foo);
```

You might be surprised to learn that this will (generally) print out 'o' on a line. Whaaaaa?!?! Actually, it is quite simple. The strings are allocated one after another. So memory looks like this:

```
[ h][ e][ y][\0][ y][ o][ u][\0]
 56  57  58  59  60  61  62  63
```

The second line is the address associated to these bytes. As you can see, 56+2 indeed points to a 'y' character. And, sure enough, 56 + 5, or 61, points to an 'o' character. As you can see, pointers directly map to the underlying memory. They lose all association to their original data structure. They are just numbers. Pretty tame, and extremely simple.

To aid programmers, the designers of C decided that pointer math is special. Why would anyone want to address something within an int? or within a struct? You wouldn't generally need to do this. So, when an integer is added to a pointer, the address is incremented in steps of the size of the type the pointer refers. Let's just look at examples:

``` c
char* foo = 56; foo + 1;        // foo == 57
short* foo = 56; foo + 1;       // foo == 58 assuming shorts are 2 bytes
int* foo = 56; foo + 1;         // foo == 60 assuming ints are 4 bytes
struct node* foo = 56; foo + 1; // foo == 56 + sizeof(node)
```

Interesting. And confusing. And prone to error. But, ultimately more useful than simply adding to the address itself, right? So, it makes sense.

In the malloc assignment, it is bad to do this:

``` c
struct node* foo = sbrk(sizeof(node) + size);
return foo + sizeof(node);
```

Good to do this:

``` c
return (char*)foo + sizeof(node);
```

Or this:

```
return foo + 1;
```

## Style

Pft. Style? How can style be a legitimate programming issue? Because reading code is the most important facet of programming. If your code is not legible, your code is next to worthless.

> Programs must be written for people to read, and only incidentally for machines to execute.
>
> <div class="citation">&mdash; <cite>Abelson & Sussman</cite>, <a href="http://www.amazon.com/Structure-Interpretation-Computer-Programs-Engineering/dp/0262011530/sr=8-1/qid=1163785017?ie=UTF8&s=books">Structure and Interpretation of Computer Programs</a></div>

That pretty much sums it up. Programs are for people. I mean, that's the entire point of a programming language, after all. Just as it is with a natural language, such as English, there are conventions that, when used, make the writing easier to consume. You have all read different writing styles, and understand that certain styles appeal to you more than others. In the programming world, just as the literary world, these styles are debated. One thing is true: by sticking to the correct convention for your audience, you are more easily understood.

That said, each language has its own standard for conventions. This has to do with tab spacing, hard or soft tabs, function naming, brace position, file structure... you name it. In Java, for instance, functions are written in **camelCase**, while classes are named in the uppercase variant or **UpperCamelCase** (aka **PascalCase**). Constants are in **ALLCAPS**. Typically these conventions are not defined as part of the language. That is, the parser (technically the lexer) does not look for, treat differently, or cause an error when these conventions go unused. Other languages, such as Ruby, give these conventions semantic meaning. For instance, defining a variable name in all caps will create a constant.

C works like Java (Java is, after all, a **C-family language**... ok fine... they are both **Algol-family** for you programming-language-smartypants out there.) That is, the conventions are not enforced by the language, they are social. That said, after 40 years, the conventions are very rigid and surprisingly common. This is a testament to how necessary they truly are.

* **Function names**: void these\_lowercase\_things\_have\_underscores(int a, int b, int c, void *p) { }
* **Constants**: ALL\_CAPITAL\_LETTERS
* **Tabs**: There isn't a preference. Hard or soft (that is, just using spaces instead). Spaces are generally more consistent, and your editors can generally emit them when you press 'tab'.
* **Tab Size**: nowadays 2 or 4 spaces.

## Mistake #4 - Dropping void off of functions

ALWAYS put the void before a function that returns nothing. It has meaning. For the same reason an implied subject is weird in English writing... don't drop nouns in your programs. In fact, by not putting void in front, it's actually a function that returns int. So, now you have an int-function that has no return. Eww! Always specify the return type; enough said. :)

``` c
/* A */ void f(void);
/* B */ f(void);

/* A and B have VASTLY different return types! */
```

## Mistake #5 - Wrong conventions for functions

Why is myBestFitMalloc() confusing when you expect to see a C function call? Because that does not look like a C function call. So, the code does not flow very well when you are trying to read through it. It does not register as a function call immediately. That slows everything down. If you use a library that names its functions a different way than you, your code will look fairly ugly due to the inconsistency. Another good reason to commit to the *standard conventions*. Guess what... everybody conforms to this out in the wild. Lowercase with underscore delimiters. It may not look good to you, but it looks beautiful to everybody else.

## Mistake #6 - Indentation

Why is this important? Because of how nice it is to quickly identify scope. I generally read code and know that a variable declared in a certain column will be alive as long as the indentation is at least that wide. I know where a while loop begins and ends just by skimming. If you misplace one tab or space, your code becomes drastically harder to read. Also, ensure that your brackets are always positioned the same way. If you put them on the same line as the **if**, then do that always. Overall, consistency is what matters. It is so important, that there is a standard UNIX program (indent) that will correct and switch indentation styles.

So, by all means, decide among yourselves whether you will choose tabs or spaces, **vim** or emacs, [K&R or Allman](http://en.wikipedia.org/wiki/Indent_style) (K&R K&R **K&R!!!**). If you choose *Whitesmiths*... I... I just can't save you.

## Mistake #7 - Functions that do not take arguments

People really do not understand this, and you see this often.

``` c
/* A */ void f();
/* B */ void f(void);
```

I do not blame you. In C++ or Java, (A) would be the correct choice to describe a function that has no arguments. However, in C, it is actually choice (B). Why? Because (A) is a function that takes any number of arguments. So, if you used (A) in C, you could call it with foo(2, 4, "hello") and it would fire and maybe this has consequences you do not expect. Therefore, you use construction (B). I will *not see any of you make this mistake*. Resist the temptation, and you are now better than 80% of all C programmers ever. :)

## Mistake #8 - The one-letter variable name

Hey! HEY! Do not use one-letter variable names. Names are there for you. The human being in front of the keyboard. The computer throws them away. So, why make them so cryptic? It's only acceptable in certain conventional places, like using 'i' for a loop counter. (Even then, that's weird. Because some people use 'i' as a pure counter and *not as an index*. Confusing.)

## Mistake #9 - The all powerful function

Congratulations on reading this far. This part is about a common problem a lot of new programmers face: the megalomanical function. It's a function that believes it is an infallible god that was created to do all. It cooks AND cleans. It accelerates AND brakes. It grows the plants, sows the fields, and harvests the produce at the end of the season. Here's the thing... functions should do **one** thing. Absolutely nothing more. That's its purpose: to provide **a** function. The technical term for what a function does is its **behavior**. Isn't it hard enough to get it to behave in one particular way, let alone many?

When a function does just one thing, it is easier to write, easier to understand, easier to maintain, easier to throw away and start over (**refactor**), easier to debug, and easier to test manually or write automated tests (**specifications**) to ensure its correctness.

How do you detect a runaway, malevolent function? You can... smell it. You can tell when something... smells a little fishy. So, look for **code smells**! (Yes... that's the technical term. I didn't invent it; don't look at me that way.)

1. **Variable declarations halfway down a function**

    You know that code you write where you do something and then you declare a bunch of new things about halfway through a function body? Yeah. Don't do that. Why? It's a *smell*. It says "Hey. I'm switching jobs here... putting on this new hat." That means you have written two functions and given it the same name and put it in the same body. Have you ever seen Siamese twins where one wanted to go into show business but the other was camera shy? Not. Good. People.

2. **Many returns**

    When you have many exits for your little function highway, it can seem extremely useful. And, sure, it is useful. This function gleefully reacts to many different situations and conditionally responds to many different stimuli. But, in the end, this can be an indication that this function is doing **far far** too much. Think about drawing your function out as a flow chart. It should really be able to fit neatly on a small piece of paper and roughly be linear. If it is not... well, draw it out anyway. What are you looking for? Small isolated pockets of activity. These pockets should have been functions... and now you can pull them out and simply call them appropriately. It could very well be that each return in your original function represents a separate behavior and therefore should just be its own function.

    As my grandmother used to say, "One function too many is better than one function too mangy."

3. **Finding yourself adding something within a function**

    You know that thing that isn't broken? What do you do with that thing... oh right. You **don't fix it**. If you are ever like... "this function should do more," lick a battery and stop yourself from believing that's true. That function is **just fine**. What you want is a new function to perform that new behavior. If that means breaking up the function you have into two pieces... so be it. If you can't add the behavior you want without breaking a function up... then that function *needed* to be broken apart. Let's not create big functions. If we make too many of them, they might lobby Congress to be considered people.

    There are other smells, for instance the trivial "It doesn't fit on a single page in my text editor," but generally it's obvious when you've gone **too far**.

As you can see. Style is serious business. It is why there are points for it on the assignments, and it is why I'm so critical about it. It's for your own good! :)

Happy Hacking,
wilkie
