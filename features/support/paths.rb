# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
  when /^the sign up page$/
    new_user_registration_path
  when /^the create resource page$/
    new_resource_path
  when /^the create demand page for "(.*)"$/
    #print "Resource.find_by_name($1) = "+Resource.find_by_name($1).to_s
    new_resource_demand_path(Resource.find_by_name($1).id)
  when /^the resource detail page of "(.*)"$/
    resource_path(Resource.find_by_name($1).id)
  when /^the login page$/
    user_session_path
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
