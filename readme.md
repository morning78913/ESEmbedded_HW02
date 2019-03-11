HW02
===
This is the hw02 sample. Please follow the steps below.

# Build the Sample Program

1. Fork this repo to your own github account.

2. Clone the repo that you just forked.

3. Under the hw02 dir, use:

	* `make` to build.

	* `make clean` to clean the ouput files.

4. Extract `gnu-mcu-eclipse-qemu.zip` into hw02 dir. Under the path of hw02, start emulation with `make qemu`.

	See [Lecture 02 ─ Emulation with QEMU] for more details.

5. The sample is designed to help you to distinguish the main difference between the `b` and the `bl` instructions.  

	See [ESEmbedded_HW02_Example] for knowing how to do the observation and how to use markdown for taking notes.

# Build Your Own Program

1. Edit main.s.

2. Make and run like the steps above.

# HW02 Requirements

1. Please modify main.s to observe the `push` and the `pop` instructions:  

	Does the order of the registers in the `push` and the `pop` instructions affect the excution results?  

	For example, will `push {r0, r1, r2}` and `push {r2, r0, r1}` act in the same way?  

	Which register will be pushed into the stack first?

2. You have to state how you designed the observation (code), and how you performed it.  

	Just like how [ESEmbedded_HW02_Example] did.

3. If there are any official data that define the rules, you can also use them as references.

4. Push your repo to your github. (Use .gitignore to exclude the output files like object files or executable files and the qemu bin folder)

[Lecture 02 ─ Emulation with QEMU]: http://www.nc.es.ncku.edu.tw/course/embedded/02/#Emulation-with-QEMU
[ESEmbedded_HW02_Example]: https://github.com/vwxyzjimmy/ESEmbedded_HW02_Example

--------------------

- [ ] **If you volunteer to give the presentation next week, check this.**

--------------------

Please take your note here.

# 實驗題目

觀察暫存器在有順序的`push`以及`pop`的情況底下會不會影響執行結果?

1.修改`main.s`檔如下圖

```
.syntax unified

.word 0x20000100
.word _start

.global _start
.type _start, %function
_start:
        //
        //mov # to reg
        //
        mov     r0,     #1
        mov     r1,     #2
        mov     r2,     #3

        //      
        //push and pop
        //
        push    {r0, r1, r2}
        pop     {r3, r4, r5}

        //reset
        mov     r0,     #0
        mov     r1,     #0
        mov     r2,     #0
        mov     r3,     #0
        mov     r4,     #0
        mov     r5,     #0
//=======================================
        //
        //mov # to reg
        //
        mov     r0,     #1
        mov     r1,     #2
        mov     r2,     #3

        //
        //push and pop
        //
        push    {r2, r0, r1}
        pop     {r3, r4, r5}

```

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/1_main_s.jpg)

* Step12~14是將r0, r1, r2分別存入值1, 2, 3
* 接著依序`push`r0, r1, r2
* 可以發現到值1, 2, 3分別被存在以下位址中:

0x200000fc | 0x200000f8 | 0X200000f4
------------ | ------------ | ------------
3 | 2 | 1

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/3_push_1.jpg)

* 可以發現`pop`出來至r3, r4, r5觀察結果即為:

r3 | r4 | r5
------------ | ------------ | ------------
3 | 2 | 1

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/4_pop_1.jpg)

### 如果將原先的r0, r1, r2順序改為r2. r0, r1呢?

* 此時可以看到0x3c的順序再編譯之後被改成了r0, r1, r2並且`push`進去

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/5_PUSH_2.jpg)

* 而r3, r4, r5在經過`pop`同樣為:

r3 | r4 | r5
------------ | ------------ | ------------
3 | 2 | 1

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/6_POP_2.jpg)

結果與討論
===

* 其實經由編譯後出現的警告訊息就可以知道

![image](https://github.com/morning78913/ESEmbedded_HW02/blob/master/img/2_Warning%20message.jpg)

### 實驗結果

1. 任意改變`push`以及`pop`的順序並不會影響執行的結果，也就是說如果將原先的r0, r1, r2順序改為r2, r0, r1在編譯過後，編譯器會自動依序調整為r0, r1, r2的順序，而且會優先的讓r0`push`進stack。

2. 程式的第一階段會`push`三種不同的值進去，隨後再`pop`丟給r3, r4, r5以利觀察結果。隨後會將r0~r5全部清空方便下次的觀察，只是第二階段的順序將會改成`r2, r0, r1`。
