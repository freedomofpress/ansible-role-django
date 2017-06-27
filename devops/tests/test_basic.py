import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    '.molecule/ansible_inventory').get_hosts('all')


def test_mainpage(Command):
    """
    Basic test to make sure home-page is coming up.
    """
    SITE_STRING = "Little Weaver Web Collective"

    # When running under CI, the docker environment is remote and ports are
    # readily accessible remotely. In that case poll from the docker image
    # instead of from the host
    content = Command.check_output("curl -k https://localhost:443")
    head = Command.check_output("curl -I -k https://localhost:443")
    assert SITE_STRING in content
    assert "HTTP/1.1 200 OK" in head
