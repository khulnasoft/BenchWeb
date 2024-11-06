from setuptools import setup, find_packages

requires = [
    "pyramid",
    "pyramid_chameleon",
    "sqlalchemy[postgresql]",
    "gunicorn",
    "orjson",
]

tests_require = ["webtest"]

setup(
    name="benchweb",
    version="0.0",
    description="BenchWeb",
    classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
    ],
    author="",
    author_email="",
    url="",
    keywords="web pyramid pylons",
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=requires,
    tests_require=tests_require,
    test_suite="benchweb",
    entry_points="""\
      [paste.app_factory]
      main = benchweb:main
      """,
)
