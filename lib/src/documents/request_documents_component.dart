import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-documents',
    templateUrl: 'request_documents_component.html',
    directives: const [RouterLink])
class RequestDocumentsComponent implements OnInit, AfterViewInit {
  static const String route_name = 'RequestDocuments';
  static const String route_path = 'documents';
  static const Route route = const Route(
      path: RequestDocumentsComponent.route_path,
      component: RequestDocumentsComponent,
      name: RequestDocumentsComponent.route_name);

  final Router _router;
  final RouteParams _routeParams;

  RequestDocumentsComponent(this._router, this._routeParams) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>            
            <li class="breadcrumb-item active">Первичная документация</li>
    ''';
  }

  @override
  void ngAfterViewInit() {
    var button = querySelector('[btn-aprove]') as ButtonElement;
    button.onClick.listen((MouseEvent e) {
      _router.navigate(['RequestList']);
    });

    window.onScroll.listen((Event e) {
      var nav = querySelector('[sticky]') as HtmlElement;

      var e = window.pageYOffset,
        t = 40,
        n = window.innerHeight,
        i = t - e,
        r = min(n, i) - 50;

      nav.style.setProperty('height', r*-1 + 'px');
    });

    var summary = querySelector('[summary-block]') as DivElement;
    var works = querySelector('[works-and-materials-block]') as DivElement;

    window.scrollTo(0,0);
  }
}
