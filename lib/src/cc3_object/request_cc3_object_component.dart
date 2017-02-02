import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(
    selector: 'request-cc3', templateUrl: 'request_cc3_object_component.html')
class RequestCc3ObjectComponent implements AfterViewInit {
  static const String route_name = 'RequestCc3Object';
  static const String route_path = 'cc-3/:objectName';
  static const Route route = const Route(
      path: RequestCc3ObjectComponent.route_path,
      component: RequestCc3ObjectComponent,
      name: RequestCc3ObjectComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final RouteParams _routeParams;

  RequestCc3ObjectComponent(
      this._router, this._resourcesLoaderService, this._routeParams) {}

  @override
  ngOnInit() {
    String objectName = _routeParams.get('objectName');
  }

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item"><a href="#/master/request/cc-3">Справки КС-3</a></li>
            <li class="breadcrumb-item active">Морской порт</li>
    ''';
  }

  @override
  void ngAfterViewInit() {

    breadcrumbInit();

    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');

    _resourcesLoaderService.loadScript(
        'vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoaderService.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadStyle(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

  }
}
