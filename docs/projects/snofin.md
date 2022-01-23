# Full-Stack Clojure Web App with Python Interpreter
[Source: Github Link](https://github.com/LukeAlbarracin/snofin-web-cljs)
<p> This project was inspired by my initial discovery of the <a href="https://www.graalvm.org/docs/introduction/">GraalVM</a> (a Java VM and JDK). I had discovered GraalVM after learning the basics of token parsing and abstract syntax trees (AST) from creating Rust macros. GraalVM uses <a href="https://www.graalvm.org/reference-manual/java-on-truffle/">Truffle</a>
, which is a Java library that utilizes ASTs and aims to allow interopability between programming languages. </p>
<p>
Because of this, I sought out this mini project, to see how simple it is to execute python shell commands in Clojure, thus creating this app. I chose Python because for my computer science club, that was the language that many kids aimed to learn. </p>
###1. `Clojure` - Execute Python, JSON, and Websockets
[Source: Websockets.clj](https://github.com/LukeAlbarracin/snofin-web-cljs/blob/master/src/multi_client_ws/routes/websockets.clj)
<p> Executes Python, using a Java Library (Clojure has Java interop). The results from whatever Python was executed is parsed out, then sent over to the client via websockets using <a href="https://http-kit.github.io/"> http-kit</a>. This data is sent over in JSON format.</p>
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
###2. `ClojureScript` - Reagent and UI
[Source: Core.cljs](https://github.com/LukeAlbarracin/snofin-web-cljs/blob/master/src-cljs/multi_client_ws/core.cljs)
<p><a href="https://github.com/reagent-project/reagent"> Reagent </a> is a minimalistic interface between ClojureScript (CLJS) and React. React components can be composed using CLJS functions and data in hiccup-format. In this project, a button is designed to send over values from an input field via websockets. </p>
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
###3. `Clojure` - JSON Parsing in Clojure
[Source: Websockets.clj](https://github.com/LukeAlbarracin/snofin-web-cljs/blob/master/src/multi_client_ws/routes/websockets.clj)
<p>Converts a JSON-encoded map into a Clojure string utilizing Java interop and the <a href="https://github.com/cognitect/transit-clj">Transit</a> library. </p>
```Clojure
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