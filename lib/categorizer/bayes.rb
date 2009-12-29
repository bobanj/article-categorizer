module Categorizer
  class Bayes
    attr_reader :categories, :categories_documents, :total_documents, :threshold, :total_words, :categories_words, :words

    def initialize(categories)
      @categories = categories
      @words = Hash.new
      @total_words = 0
      @categories_documents = Hash.new
      @total_documents = 0
      @categories_words = Hash.new

      categories.each { |category|
        @words[category] = Hash.new
        @categories_documents[category] = 0
        @categories_words[category] = 0
      }
    end

    def train(category, document)
      return if category.blank?
      unless @categories.include? category
        @categories << category
        @words[category] = Hash.new
        @categories_documents[category] = 0
        @categories_words[category] = 0
      end
      word_count(document).each do |word, count|
        @words[category][word] ||= 0
        @words[category][word] += count
        @total_words += count
        @categories_words[category] += count
      end
      @categories_documents[category] += 1
      @total_documents += 1
    end

    def word_count(document)
      words = document.gsub(/\n+/, ' ').gsub(/[^\w\s]/, "").split
      d = Hash.new
      words.each do |word|
        word.downcase!
        key = word
        unless COMMON_WORDS.include?(word)
          d[key] ||= 0
          d[key] += 1
        end
      end
      return d
    end

    def probabilities(document)
      probabilities = Hash.new
      @words.each_key {|category|
        probabilities[category] = probability(category, document)
      }
      return probabilities
    end

    def probability(category, document)
      doc_probability(category, document) #* category_probability(category)
    end

    def doc_probability(category, document)
      doc_prob = 1
      word_count(document).each { |word|
        doc_prob += Math.log(word_probability(category, word[0]))
      }
      return doc_prob
    end

    def word_probability(category, word)
      (@words[category][word].to_f + 1)/@categories_words[category].to_f
    end

    def category_probability(category)
      @categories_documents[category].to_f/@total_documents.to_f
    end

    def classifications(document)
      score = Hash.new
      @categories.each {|category|
        score[category] = 0
        word_count(document).each { |word|
          s = @words[category].has_key?(word[0]) ? @words[category][word[0]] : 0.1
          score[category] += Math.log(s/@categories_words[category].to_f)
        }
      }
      return score
    end

    def myclassify(document)
      (classifications(document).sort_by { |a| -a[1] })[0][0]
    end


    def classify(document)
      sorted = probabilities(document).sort {|a, b| a[1] <=> b[1]}
      best = sorted.pop
      return best[0]
    end

    def category_with_most_articles
      @categories_documents.sort{|a, b| a[1] <=> b[1]}.last[0]
    end

    COMMON_WORDS = []
  end
end