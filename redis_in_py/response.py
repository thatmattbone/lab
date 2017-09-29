"""
Redis responses.

This should be refactored with some of the stuff in server.py.
"""


class BaseResponse(object):
    def response_lines(self):
        raise NotImplementedError


class NullResponse(BaseResponse):
    def response_lines(self):
        return [b"$-1"]