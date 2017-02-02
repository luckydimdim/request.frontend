import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-cc2',
    templateUrl: 'request_cc2_object_component.html',
    directives: const [RouterLink])
class RequestCc2ObjectComponent implements AfterViewInit, OnInit {
  static const String route_name = 'RequestCc2Object';
  static const String route_path = 'cc-2/:objectName';
  static const Route route = const Route(
      path: RequestCc2ObjectComponent.route_path,
      component: RequestCc2ObjectComponent,
      name: RequestCc2ObjectComponent.route_name);

  final Router _router;
  final RouteParams _routeParams;

  RequestCc2ObjectComponent(this._router, this._routeParams) {}

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
            <li class="breadcrumb-item"><a href="#/master/request/cc-2">Акты КС-2</a></li>
            <li class="breadcrumb-item active">Морской порт</li>
    ''';
  }

  @override
  void ngAfterViewInit() {
    breadcrumbInit();

    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
