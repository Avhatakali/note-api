require 'rails_helper'

RSpec.describe 'Notes APi', type: :request do
  let(:user) { create(:user) }
  let!(:notes) { create_list(:note, 10, user_id: user.id) }
  let(:note_id) { notes.first.id }
  let(:headers) { valid_headers }

  describe 'GeT /notes' do
    before { get '/notes', params: {}, headers: headers }

    it "return notes" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /notes/:id' do
    before { get "/notes/#{note_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:note_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'POST /notes' do
    let(:valid_attributes) do
      { content: 'Learning Notes', user_id: user.id }.to_json
    end

    context 'when the request is valid' do
      before { post '/notes', params: valid_attributes, headers: headers }

      it "creates a note" do
        expect(json['content']).to eq('Learning Notes')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { content: nil }.to_json }
      before { post '/notes', params: invalid_attributes, headers: headers }

      it 'returns status code of 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure code message' do
        expect(json['message']).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /notes/:id' do
    let(:valid_attributes) { { content: 'Learning Notes' }.to_json }

    context 'when the record exists' do
      before { put "/notes/#{note_id}", params: valid_attributes, headers: headers }
      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /notes/:id' do
    before { delete "/notes/#{note_id}", params: {}, headers: headers }

    it "return status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
