import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'request', templateUrl: 'request_component.html')
class RequestComponent implements AfterViewInit {
  static const String route_name = 'Request';
  static const String route_path = 'Request';
  static const Route route = const Route(
      path: RequestComponent.route_path,
      component: RequestComponent,
      name: RequestComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoader;

  RequestComponent(this._router, this._resourcesLoader) {}

  @override
  void ngAfterViewInit() {
    _resourcesLoader.loadScript('assets/js/', 'app.js', false);

    _resourcesLoader.loadScript('vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoader.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoader.loadStyle(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

    _resourcesLoader.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoader.loadScript('packages/request/src/', 'init.js', false);
  }
}