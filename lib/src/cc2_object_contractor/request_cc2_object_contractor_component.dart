import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(selector: 'request-cc2', templateUrl: 'request_cc2_object_contractor_component.html')
class RequestCc2ObjectContractorComponent implements AfterViewInit, OnInit {
  static const String route_name = 'RequestCc2ObjectContractor';
  static const String route_path = 'cc-2/:objectName/:contractorName';
  static const Route route = const Route(
      path: RequestCc2ObjectContractorComponent.route_path,
      component: RequestCc2ObjectContractorComponent,
      name: RequestCc2ObjectContractorComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final RouteParams _routeParams;

  RequestCc2ObjectContractorComponent(this._router, this._resourcesLoaderService, this._routeParams) { }

  @override
  ngOnInit() {
    String objectName = _routeParams.get('objectName');
    String contractorName = _routeParams.get('contractorName');
  }

  @override
  void ngAfterViewInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');

    _resourcesLoaderService.loadScript(
      'vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoaderService.loadScript(
      'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadStyle(
      'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

    _resourcesLoaderService.loadScript(
      'packages/request/src/settings/', 'init-date-range.js', false);
  }
}
