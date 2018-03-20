module Refinery
  module Portfolio
    module Admin
      class GalleriesController < ::Refinery::AdminController

        crudify :'refinery/portfolio/gallery',
                :order => 'lft ASC',
                :include => [:children],
                :paging => false

        def new
          @gallery = ::Refinery::Portfolio::Gallery.new(:parent_id => find_parent_gallery)
        end

        def children
          @gallery = find_gallery
          render :layout => false
        end

        def destroy_items
          @gallery = find_gallery
          @gallery.items.each do  |item|
            item.image.destroy
            item.destroy
          end
          redirect_to :back
        end

        def process_import
          gallery = ::Refinery::Portfolio::Gallery.find(params[:gallery_id])
          ImageImporterWorker.perform_async(gallery.id)
          redirect_to :back, notice: 'Importing Images'
        end

        protected

        def find_parent_gallery
          @parent_gallery = ::Refinery::Portfolio::Gallery.find(params[:parent_id]) if params[:parent_id].present?
        end

        def find_gallery
          @gallery = ::Refinery::Portfolio::Gallery.find(params[:id]) if params[:id].present?
        end

      end
    end
  end
end
