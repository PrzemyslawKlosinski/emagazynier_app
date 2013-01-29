module UsersHelper

	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user, options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
		image_tag(gravatar_url, alt: user.name+" banner", class: "gravatar")
	end



  def popover(model_name, attribute)
    i18n_base = "simple_form.popovers.#{model_name.downcase}.#{attribute}"

    content_tag(:i, '', class: "icon-question-sign",
                        id: "#{attribute}_help",
                        title: I18n.t("#{i18n_base}.title"),
                        data: {
                            # don't use popover as it conflicts with the actual pop-over thingy
                            pop_over: true,
                            content: I18n.t("#{i18n_base}.text")
                        })
  end


end



