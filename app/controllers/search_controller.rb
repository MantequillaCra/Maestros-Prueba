class SearchController < ApplicationController
  def results
    @teacher = Teacher.buscador(params[:termino])
    @article = Article.buscador(params[:termino])
    @results = @teacher + @article
  end
end
