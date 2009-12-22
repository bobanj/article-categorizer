class MainController < ApplicationController
  def index
    @category = ""
    @text = params[:categorize][:text] 
   if request.post?
    Categorizer::Bayes.class
    categorizer = ObjectStash.load CATEGORIZER_PATH
    @category = categorizer.classify(params[:categorize][:text])
   end

  end

end
