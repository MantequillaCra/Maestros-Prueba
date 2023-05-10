class TeachersController < ApplicationController
  before_action :authenticate_user! , except:[:index, :show]

  #Muestra una lista de los articulos
  def index
    @teachers = Teacher.all
  end

  #Muestra un articulo (por su ID)
  def show
    @teacher = Teacher.find(params[:id])
  end

  #Crea un nuevo articulo
  def new
    @teacher = Teacher.new
  end

  #Guarda el articulo creado
  def create
    @teacher = current_user.teacher.new(teacher_params)
    if @teacher.save
      redirect_to @teacher
    else
      render :new, status: :unprocessable_entity
    end
  end

  #Edita un articulo (por su ID)
  def edit
    @teacher = Teacher.find(params[:id])
  end

  #Guarda el articulo editado
  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      redirect_to @teacher
    else
      render :new, status: :unprocessable_entity
    end
  end

  #Elimina un articulo
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def teacher_params
    params.require(:teacher).permit(:title, :user_id)
  end
end
