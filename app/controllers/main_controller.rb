class MainController < ApplicationController
  def index
    @category = ""
    if request.post?
      @text = params[:categorize][:text] rescue ""
      Categorizer::Bayes.class
      categorizer = ObjectStash.load CATEGORIZER_PATH
      @category = categorizer.classify(params[:categorize][:text])
    end

  end

end
