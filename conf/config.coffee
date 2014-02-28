production = process.env.NODE_ENV is "production"
development = process.env.NODE_ENV is "development"

	# production configuration
# else if development
	# development configuration
if production
	exports.db = 'mongodb://localhost/cooke'
	exports.domain = 'localhost'
	exports.port = port = process.env.PORT or 3000
	exports.base = 'http://localhost:' + port
else
	# local configuration
	exports.db = 'mongodb://localhost/colors'
	exports.domain = 'localhost'
	exports.port = port = process.env.PORT or 3000
	exports.base = 'http://localhost:' + port
