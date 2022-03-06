# 1
FROM swift:5.4-focal
# 2
WORKDIR /package
# 3
COPY . ./
# 4
CMD ["swift", "test", "--enable-test-discovery"]”
