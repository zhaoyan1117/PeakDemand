class UserMailerController < ApplicationController
	def send_email
		user = User.find_by_id(param[:id])
		UserMailer.welcome_email(user).deliver