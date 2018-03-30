import flask
import connexion
import six


def version_get():  # noqa: E501
    """Gets api version

    Returns a version of the api. # noqa: E501


    :rtype: str
    """

    app = flask.current_app
    return app.config['VERSION']
