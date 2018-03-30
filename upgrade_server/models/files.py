# coding: utf-8

from __future__ import absolute_import
from datetime import date, datetime  # noqa: F401

from typing import List, Dict  # noqa: F401

from upgrade_server.models.base_model_ import Model
from upgrade_server import util


class Files(Model):
    """NOTE: This class is auto generated by the swagger code generator program.

    Do not edit the class manually.
    """

    def __init__(self):  # noqa: E501
        """Files - a model defined in Swagger

        """
        self.swagger_types = {
        }

        self.attribute_map = {
        }

    @classmethod
    def from_dict(cls, dikt) -> 'Files':
        """Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The files of this Files.  # noqa: E501
        :rtype: Files
        """
        return util.deserialize_model(dikt, cls)