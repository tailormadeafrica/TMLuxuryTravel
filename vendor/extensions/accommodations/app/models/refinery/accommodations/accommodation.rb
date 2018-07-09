module Refinery
  module Accommodations
    class Accommodation < Refinery::Core::BaseModel
      self.table_name = 'refinery_accommodations'      
    
      acts_as_indexed :fields => [:name, :rating, :description]

      after_save :remove_span

      extend FriendlyId
      friendly_id :name, :use => [:slugged]

      attr_accessible :name, :bread, :cover_image_id, :rating, :description, :position, :activity_ids, :location_id, :latitude, :longitude, :address, :gallery_id, :sub_name, :location_ids, :amenity_ids,
      :low_rate, :mid_rate, :high_rate, :jan, :feb, :marc, :apr, :may, :jun, :jul, :aug, :sept, :oct, :nov, :dec, :slug, :browser_title, :meta_description, :exclusion, :inclusion

      validates :name, :presence => true, :uniqueness => true
      # validates :low_rate, :presence => true
      # validates :high_rate, :presence => true
      # validates :mid_rate, :presence => true

      RATES = %w(Low Mid High Closed)
          
      belongs_to :cover_image, :class_name => '::Refinery::Image'
      belongs_to :gallery, :class_name => '::Refinery::Portfolio::Gallery'
      # belongs_to :location, :class_name => '::Refinery::Locations::Location'
      has_and_belongs_to_many :activities, :class_name => '::Refinery::Activities::Activity', :join_table => 'refinery_activities_accommodations'
      has_and_belongs_to_many :posts, :class_name => 'Refinery::Blog::Post', :join_table => 'refinery_accommodations_posts'
      has_and_belongs_to_many :locations, :class_name => '::Refinery::Locations::Location', :join_table => 'refinery_accommodations_locations'
      has_and_belongs_to_many :amenities, :class_name => '::Refinery::Amenities::Amenity', :join_table => 'refinery_accommodations_amenities'

      default_scope { order(:position) }

      def remove_span
        new_slug = self.slug.gsub("-span-","-").gsub("-span","")
        self.update_column(:slug, new_slug)

        accommodation = self
        links = ''

        if accommodation.locations.first.present? and accommodation.locations.first.parent.present?
          if accommodation.locations.first.parent.parent.present?
            links << accommodation.locations.first.parent.parent.slug.gsub('-',' ') + " "
            links << accommodation.locations.first.parent.slug.gsub('-',' ') + " "
          else
            links << accommodation.locations.first.parent.slug.gsub('-',' ') + " "
          end
        end
        if accommodation.locations.first.present?
            links << accommodation.locations.first.slug.gsub('-',' ') + " "
        end
        links << accommodation.slug.gsub('-',' ')

        self.update_column(:bread, links.to_s)
      end

      def is_valid?
        gallery.present? and gallery.items.present?
      end
    end
  end
end
