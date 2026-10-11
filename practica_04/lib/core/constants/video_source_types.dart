enum VideoSourceType {
  local('local'),
  remoteHttp('remote_http'),
  external('external');

  const VideoSourceType(this.value);

  final String value;

  factory VideoSourceType.fromValue(String? value) {
    switch (value) {
      case 'remote_http':
        return VideoSourceType.remoteHttp;
      case 'external':
        return VideoSourceType.external;
      case 'local':
      default:
        return VideoSourceType.local;
    }
  }
}
