import web
from twittleslide import *

urls = (
    '/(\d+)', 'twitslide'
)
app = web.application(urls, globals())

class twitslide:        
    def GET(self, twitterid):
        web.header('content-type', 'text/html') 
        return twittle_slide(twitterid)


def prod():
    application = web.application(urls, globals()).wsgifunc() 
    return application


if __name__ == "__main__":
    app.run()
