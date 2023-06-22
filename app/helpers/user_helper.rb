module UserHelper

    def check_name(user)
      if current_user.name
        @user.name
      else
        return "Please add your name"
      end
    end

    def check_photo(user, width = '', height = '')  
          
        if current_user.photo.attached?
          # return default image
          @photo = image_tag current_user.photo, width: width, height: height
            
        else
          #return user avatar
          @photo = image_tag "default_avatar.jpg", width: width, height: height
        end
      
   end

end
