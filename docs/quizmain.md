# Full-Stack Android/Java App (OOP) with Natural Language Processing (NLP)

A Quizlet inspired flashcard application which uses NLP to generate questions
<p> Aims to convert a declarative statement to a question for flashcard studying purposes </p>

* [Java Frontend with NLP for Android](https://github.com/LukeAlbarracin/QuizMaster)
* [Sprint Boot Backend using GCP with NLP](projects/quizback.md)
<hr>
# Project Highlights

###1.`Java` - Natural Language Processing (NLP)
[Source: SentenceAnalyzer.java](https://github.com/LukeAlbarracin/opennlp-java-backend/blob/master/src/main/java/com/quizmaster/opennlpjavabackend/SentenceAnalyzer.java)
<p> Gets the simplified version of an input stream, using Sentence Detection and Part-of-Speech (POS) tagging to aid in Lemmatization. Removes proper nouns, using built-in LinkedList functionality, which requires a traversal when unspecified, thus O(n) time complexity. </p>
```Java
public List<String> getTrueMeanings() throws IOException {
    InputStream stream = new ClassPathResource("en-lemmatizer.dict").getInputStream();
    DictionaryLemmatizer lem = new DictionaryLemmatizer(stream);
    List<String> lemmas = new LinkedList<String> (Arrays.asList(lem.lemmatize(detectSentence(), partOfSpeechTags())));
    lemmas.remove(new String("O"));
    return lemmas;
}
```

###2. `Java` - API Response
[Source: QuizController.java](https://github.com/LukeAlbarracin/opennlp-java-backend/blob/master/src/main/java/com/quizmaster/opennlpjavabackend/QuizController.java)
<p> Utilizes query parameters sent over from the frontend app to be analyzed with NLP, returning back a calculated response via a simple String </p>
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

###3.`Java` - OOP Polymorphism
[Source: SentenceAnalyzer.java](https://github.com/LukeAlbarracin/opennlp-java-backend/blob/master/src/main/java/com/quizmaster/opennlpjavabackend/SentenceAnalyzer.java)
<p> Overrides default .equals() method. Using Natural Language Processing, measures sentence equality. For example: "Joe walks and Joe walked" would be ruled equal due to lemmatization (removing unessential parts of a word, like tense, to its base form). </p>
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
