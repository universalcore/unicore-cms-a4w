from pyramid.config import Configurator


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    config.add_translation_dirs('unicorecmsa4w:locale')
    config.override_asset('cms:templates/', 'unicorecmsa4w:templates/')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home_jinja', '/')
    config.add_route('search_jinja', '/search/')
    config.add_route('category_jinja2', '/content/list/{category}/')
    config.add_route('content_jinja', '/content/detail/{uuid}/')
    config.add_route('locale_change_jinja', '/locale/change/')
    # NB: this must be last
    config.add_route('flatpage_jinja', '/{slug}/')
    config.include('cms')

    config.scan()

    return config.make_wsgi_app()
