class V2::NotesController < ApplicationController
  def index
    json_response({ message: 'Hello there'})
  end
end
