import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-cc3',
    templateUrl: 'request_cc3_component.html',
    directives: const [RouterLink])
class RequestCc3Component implements AfterViewInit {
  static const String route_name = 'RequestCc3';
  static const String route_path = 'cc-3';
  static const Route route = const Route(
      path: RequestCc3Component.route_path,
      component: RequestCc3Component,
      name: RequestCc3Component.route_name);

  final Router _router;

  RequestCc3Component(this._router) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item active">Справки КС-3</li>
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
