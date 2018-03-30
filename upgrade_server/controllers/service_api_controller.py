import flask
import connexion
import six

from upgrade_server.models.version import Version  # noqa: E501
from upgrade_server import util

def version_get():  # noqa: E501
    """Gets api version

    Returns a version of the api. # noqa: E501


    :rtype: str
    """

    app = flask.current_app
    resp = Version()
    resp.version = app.config['VERSION']
    return resp
