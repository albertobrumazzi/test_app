class NotesController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    @notes = current_user.notes.order(priority: :desc).order(date: :asc).order(title: :asc)
    @notes = @notes.where("notes.title like ? or notes.description like ?", "%#{params[:title]}%", "%#{params[:title]}%") if params[:title].present?
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.js { render inline: "window.location.reload()" }
        format.json { render :show, status: :created, location: @note }
      else
        format.js {render inline: "Swal.fire({ icon: 'error', title: 'Erro ao salvar!', text: 'Necessário preencher todos os campos...'})"}
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.js { render inline: "window.location.reload()" }
        format.json { render :show, status: :ok, location: @note }
      else
        format.js {render inline: "Swal.fire({ icon: 'error', title: 'Erro ao salvar!', text: 'Necessário preencher todos os campos...'})"}
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :description, :date, :priority)
    end
end
