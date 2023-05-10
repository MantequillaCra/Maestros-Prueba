class ArticlesController < ApplicationController
  before_action :authenticate_user , except: [ :index, :show ]
  before_action :verificate_user , except: [ :index, :show, :new ]

  #Muestra una lista de los articulos
  #Es una lista de 5 en 5
  def index
    @articles_per_page = 10 #Define cuantos articlos hay por pagina
    @page = params.fetch(:page,0).to_i #es para definir que pagina estoy, empieza en 0
    #offset(@page*@articles_per_page), cuando page=2, quitando_los_primeros(2*@articulos_per_page)
    @articles = Article.offset(@page*@articles_per_page).limit(@articles_per_page)  #delimita la impresion de @articles dejando que solo pasen
    @page_count = Article.all.length/@articles_per_page
    if @page < 0
      redirect_to articles_path(page:@page+1)
    else
      if Article.all.length % @articles_per_page != 0
        @page_count = @page_count + 1
      end
    end
    if @page_count <= @page
      redirect_to articles_path(page:@page-1)
    end
  end

  #Muestra un articulo (por su ID)
  def show
    @article = Article.find(params[:id])
  end

  #Crea un nuevo articulo
  def new
    @article = Article.new
  end

  #Guarda el articulo creado
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  #Edita un articulo (por su ID)
  def edit
    @article = Article.find(params[:id])
  end

  #Guarda el articulo editado
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  #Elimina un articulo
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  
  def authenticate_user
    #si no has iniciado sesion
    unless current_user
      #redirigeme a inicio sesion
      redirect_to new_user_session_path
    end
  end

  def verificate_user
    #si no eres administrador o eres el creador
    unless  current_user == User.ids || current_user.role >= 1
      #redirigeme a index/articles
      redirect_to articles_path
    end
  end

  def pagination



  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
