class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  def index
    @notes = Note.all
    json_response(@notes)
  end

  def show
    json_response(@note)
  end

  def create
    @note = Note.create!(note_params)
    json_response(@note, :created)
  end

  def update
    @note.update(note_params)
  end

  def destroy
    @note.destroy
  end

  private
    def note_params
      params.permit(:content, :created_by)
    end

    def set_note
      @note =  Note.find(params[:id])
    end
end
