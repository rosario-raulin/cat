module: cat

define generic cat (thing) => ();

define method cat (thing :: <string>) => ()
  with-open-file(s = thing, element-type: <byte>)
    cat(s);
  end with-open-file;
end method cat;

define method cat (thing :: <stream>) => ()
  block()
    while(#t)
      let (line, newline?) = read-line(thing);

      write(*standard-output*, line);
      if(newline?)
        write-element(*standard-output*, '\n');
      end if;

      force-output(*standard-output*); // is this necessary?
    end while;
  exception (e :: <end-of-stream-error>)
  end block;
end method cat;

define function main(app-name :: <string>, args :: <vector>) => ()
  let i :: <integer> = 0;
 
  block()
    for(i from 0 below args.size)
      cat(if(args[i] = "-") *standard-input* else args[i] end);
    end for;
  exception (e :: <file-does-not-exist-error>)
    format(*standard-error*, "%s: %s: file or directory not found!\n",
           app-name, args[i]);
  end block;
end function main;

main(application-name(), application-arguments());
