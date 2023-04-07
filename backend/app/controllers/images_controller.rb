class ImagesController < ApplicationController
    def show
        send_file Rails.root.join('public', 'images', 'placeholder.png'), type: 'image/png', disposition: 'inline'
    end
end