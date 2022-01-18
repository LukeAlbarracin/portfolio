# Sprint Boot Backend using GCP with NLP
* [Source: Github Link](https://github.com/LukeAlbarracin/opennlp-java-backend)
<hr>
# `Java` - Lemmatizer (NLP)
```Java
public List<String> getTrueMeanings() throws IOException {
    InputStream stream = new ClassPathResource("en-lemmatizer.dict").getInputStream();
    DictionaryLemmatizer lem = new DictionaryLemmatizer(stream);
    List<String> lemmas = new LinkedList<String> (Arrays.asList(lem.lemmatize(detectSentence(), partOfSpeechTags())));
    lemmas.remove(new String("O"));
    return lemmas;
}
```

# `Java` - Dynamic Polymorphism

```Java
@Override
    public boolean equals(Object o) {
        // Idea : create a model that analyzes the similarity between answers
        if (o == this) {
            return true;
        } else if (o == null || !(o instanceof SentenceAnalyzer)) {
            return false;
        }
        SentenceAnalyzer analyzer = (SentenceAnalyzer) o;
        try {
            return analyzer.getTrueMeanings().equals(this.getTrueMeanings());
        } catch (IOException exception) {
            System.out.println("IOException found: " + exception);
            return false;
        }
    }
```

# `Java` - API Response
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