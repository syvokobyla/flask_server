# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from upgrade_server.test import BaseTestCase


class TestServiceApiController(BaseTestCase):
    """ServiceApiController integration test stubs"""

    def test_version_get(self):
        """Test case for version_get

        Gets api version
        """
        response = self.client.open(
            '/upgrade/version',
            method='GET')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
