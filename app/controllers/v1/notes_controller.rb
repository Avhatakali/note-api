module V1
  class NotesController < ApplicationController
    before_action :set_note, only: [:show, :update, :destroy]
    def index
      @notes = current_user.notes
      json_response(@notes)
    end

    def show
      json_response(@note)
    end

    def create
      @note = current_user.notes.create!(note_params)
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
      params.permit(:content)
    end

    def set_note
      @note = Note.find(params[:id])
    end
  end
end
