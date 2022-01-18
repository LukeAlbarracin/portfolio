# Rust macro exploration of tail-call optimization

## `Rust` - Using Function-Like Macros with Tokens  - Backend
[Source: GitHub link](https://github.com/LukeAlbarracin/recursion-rust)
<p> This attempt was after learning about Clojure <strong> macros </strong>. Inspired by them, upon learning the basics of the systems language Rust, I set out to utilize their macros, wanting to compare the two. There are 3 different kinds of macros in Rust, and I found the function-like one the most appropriate for the given task : tail-call optimization. The macro works by stripping down the function passed into it by its most essentially parts, which is the function name, parameters and their respective types, the function body, and lastly the return type. </p>

<p>
Taking influence from learning dynamic programming from Clojure, I sought to take utilize memoization. I rearranged the function passed in, pointing the return value into a variable called '_memoize'. This value in theory would be stored for the next loop, where recursion was mocked. I had hoped this would prevent stuff from being added to the stack. Although this compiled and returned the correct value, there were several key flaws in it that proved unsolvable. Regardless, it was a great learning experience and introduced me to the world of token parsing and Abstract Syntax Trees (ASTs). </p>
```Rust
macro_rules! recur_fn {
    ($fpointer:ident ($($pname:ident : $type:ty),*) -> $rtrn_type:ty $fbody:block) => 
        (fn $fpointer ($($pname : $type),*) -> $rtrn_type {
            let mut _memoize = (true,$($pname),*);
            while _memoize.0 {
                fn recur (repeat:bool,$($pname:$type),*) -> (bool,$($type),*) {(true,$($pname),*)}
                _memoize = {$fbody};
            }
            fn arb_fn ($($pname : $type),*) -> $rtrn_type {$fbody}
    });
}
```