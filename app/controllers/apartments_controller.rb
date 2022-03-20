class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_with_unprocessable_entity

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = find_apartments
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment
    end

    def destroy
        apartment = find_apartments
        apartment.destroy
        head :no_content
    end

    def update
        apartment = find_apartments
        apartment = Apartment.update(apartment_params)
        render json: apartment
    end

    private

    def find_apartments
        Apartment.find(params[:id])
    end

    def apartment_params
        Apartment.permit(:number)
    end

    def render_not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def render_with_unprocessable_entity
        render json: { errors: invalid.record.errors.full.messages }, status: :unprocessable_entity
    end

end
