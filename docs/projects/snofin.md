# Full-Stack Clojure Web App with Python Interpreter
[Source: Github Link](https://github.com/LukeAlbarracin/snofin-web-cljs)
<p> This project was inspired by my initial discovery of the <a href="https://www.graalvm.org/docs/introduction/">GraalVM</a> (a Java VM and JDK). I had discovered GraalVM after learning the basics of token parsing and abstract syntax trees (AST) from creating Rust macros. GraalVM uses <a href="https://www.graalvm.org/reference-manual/java-on-truffle/">Truffle</a>
, which is a Java library that utilizes ASTs and aims to allow interopability between programming languages. </p>
<p>
Because of this, I sought out this mini project, to see how simple it is to execute python shell commands in Clojure, thus creating this app. I chose Python because for my computer science club, that was the language that many kids aimed to learn. </p>
```Clojure
(defn- execute-python! [msg]
  "Runs a python shell"
  (let [result (shell/sh "python" "-c" (json->clj msg))]
    (if (str/blank? (:err result))
      (do
        (doseq [result (str/split (:out result) #"\n") channel @channels]
          (send! channel (clj->json result))))
      (do
        (doseq [channel @channels]
          (send! channel (error->json (:err result))))))))
```

```Clojure
(defn home-page [{:keys [message]}]
  [:div.container
   [:div.row
    [:div.col-md-12
     [:center
      [:h3 "Exercise 1: Print out the number 100"]]]]
   [:div.row
    [:div.col-sm-6]]
   [:div.row
    [:div.row>div.col-sm-12
      [message-input]
      [:center
        [:button.btn.btn-primary 
          {:on-click #(do 
          (ws/send-transit-msg! {:message @value})
          (reset! messages nil)
          (reset! output @value))                           
          :style {:font-size "50px"}}
        "Execute the Python Script"]
        [:h3 "Output"]
        (for [x @messages]
          [:h2 x])
       ]
     ]]])
```

```java
(defn- json->clj [msg]
  "Converts a JSON-encoded map into a clojure string (clojure.java.string)"
  (as-> msg result
    (.getBytes result)
    (java.io.ByteArrayInputStream. result)
    (clojure.java.io/input-stream result)
    (transit/reader result :json)
    (transit/read result)
    (:message result)))
```