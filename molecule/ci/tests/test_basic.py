def test_mainpage(host):
    """
    Basic test to make sure home-page is coming up.
    """
    SITE_STRING = "Little Weaver Web Collective"

    # When running under CI, the docker environment is remote and ports are
    # readily accessible remotely. In that case poll from the docker image
    # instead of from the host
    content = host.check_output("curl -k https://localhost:443")
    head = host.check_output("curl -I -k https://localhost:443")
    assert SITE_STRING in content
    assert "HTTP/1.1 200 OK" in head


def test_gunicorn_svc_status(host):
    """
    Check that django service is set to alpha
    """
    gcorn_status_file = "/etc/ansible/facts.d/active_gunicorn_svc.fact"

    assert 'alpha' in host.file(gcorn_status_file).content_string
    assert '8000' in host.file('/etc/nginx/snippets/proxy.conf').content_string
