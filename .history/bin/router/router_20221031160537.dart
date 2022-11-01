final _router = Router()
  ..get('/', rootHandler)
  ..get('/echo/<message>', echoHandler)
  ..get('/news/', newsHandler);
