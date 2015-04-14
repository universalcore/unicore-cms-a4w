from pyramid.config import Configurator


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.add_translation_dirs('unicorecmsa4w:locale')
    config.include('cms')
    config.override_asset('cms:templates/', 'unicorecmsa4w:templates/')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home_jinja', '/')
    config.scan()

    return config.make_wsgi_app()
