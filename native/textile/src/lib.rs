use rustextile::{Textile, HtmlKind};

#[rustler::nif]
fn do_render(input: &str, opts: Vec<&str>) -> String {
    
    let mut textile = Textile::default();

    for opt in opts.iter() {
        match *opt {
            "html5" => textile = textile.set_html_kind(HtmlKind::HTML5),
            "restricted" => textile = textile.set_restricted(true),
            "sanitize" => textile = textile.set_sanitize(true),
            opt => println!("Rustextile: invalid option {:?}", opt)
        }
    }

    textile.parse(input)
}

rustler::init!("Elixir.Textile", [do_render]);
