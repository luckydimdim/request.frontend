import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-cc2',
    templateUrl: 'request_cc2_component.html',
    directives: const [RouterLink])
class RequestCc2Component implements AfterViewInit {
  static const String route_name = 'RequestCc2';
  static const String route_path = 'cc-2';
  static const Route route = const Route(
      path: RequestCc2Component.route_path,
      component: RequestCc2Component,
      name: RequestCc2Component.route_name);

  final Router _router;

  RequestCc2Component(this._router) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item active">Акты КС-2</li>
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
