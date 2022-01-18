# Portfolio of Luke

This is my portfolio.

# `Java` - Backend
```Java
@RequestMapping(value = "/process/{questionId}", method = RequestMethod.GET)
    public String process(@PathVariable int questionId) throws IOException {
        Resource quiz = getQuestion(questionId);
        String input = StreamUtils.copyToString(
            quiz.getInputStream(),
            Charset.defaultCharset());
		SentenceAnalyzer analyzer = new SentenceAnalyzer(input);
        try {
            String output = analyzer.setUpQuestion(analyzer.detectSentence());
            return output;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
	}
}
```

# Stuff

``` yaml
theme:
  features:
    - content.code.annotate # (1)
```

# `Clojure` - Backend
```Clojure
(defn num-compare [row index] 
    "Compares the two numbers"
    (if (= (nth row index) (nth row (+ index 1) nil)) 
    (do
        (swap! score + (* 2 (nth row index 0)))
        (update (update row (+ index 1) #(* % 0)) index #(* % 2))) 
    row))
```

# 'Java' - Frontend
```Java
 stringRequest.setRetryPolicy(new RetryPolicy() {
            @Override
            public int getCurrentTimeout() { return 20000; }
            @Override
            public int getCurrentRetryCount() { return 40000; }
            @Override
            public void retry(VolleyError error) throws VolleyError {}});
```






