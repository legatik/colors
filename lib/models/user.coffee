mongoose = require 'mongoose'
crypto = require 'crypto'
_ = require 'underscore'
fs = require 'fs'

ObjectId = mongoose.Schema.Types.ObjectId
Schema = mongoose.Schema

user = new Schema(
	favorites     : [{type: ObjectId, ref: 'Product'}]
	cart          : {type: ObjectId, ref: 'Cart'}
	yesorno       : Array
	name          : String
	email         : String
	vk            : String
	password      : String
	registered_on : Date
	date_request  : Date
	gender        : String
	town          : String
	confirm       : Boolean
	aboutme       : String
	birthday      : Date
	ava           : String
	balls         : String
)
Model = mongoose.model 'User', user

#Model.register = (user, cb) ->
#	# md5 create
#	self = @
#	@find {$or: [{nickname: user.nickname}, {email: user.email}]}, 'email nickname', (err, users) ->
#		if users.length
#			email = _.some(users, (u) -> u.email == user.email)
#			nickname = _.some(users, (u) -> u.nickname == user.nickname)
#			return cb and cb {email, nickname}, user
#		user.registered_on = new Date()
#		md5 = crypto.createHash 'md5'
#		md5.update user.password
#		user.password = md5.digest('base64')
#		self.create user, (err, user) ->
#			return cb and cb err, null if err
#			#path = __dirname + '/../../projects/' + user._id
#			# create user directory
#			#fs.mkdir path, '0777', (err) ->
#			cb && cb(err, user)





Model.findUser = (user, cb) ->
	md5 = crypto.createHash 'md5'
	md5.update user.password
	user.password = md5.digest('base64')
	# hash password
	@findOne user, (err, user) ->
		console.log 'findOne', err, user
		cb && cb(err, user)


module.exports = Model
