import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(selector: 'request-ts', templateUrl: 'request_ts_component.html')
class RequestTsComponent implements AfterViewInit {
  static const String route_name = 'RequestTs';
  static const String route_path = 'time-sheet';
  static const Route route = const Route(
      path: RequestTsComponent.route_path,
      component: RequestTsComponent,
      name: RequestTsComponent.route_name);

  final Router _router;

  RequestTsComponent(this._router) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item active">Time Sheet</li>
    ''';
  }

  @override
  void ngAfterViewInit() {

    breadcrumbInit();

    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');
  }
}
