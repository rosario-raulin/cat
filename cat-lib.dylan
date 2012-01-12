module: dylan-user

define library cat
  use common-dylan;
  use io;
  use system;
end library cat;

define module cat
  use common-dylan, exclude: { format-to-string };
  use format;
  use format-out;
  use file-system;
  use streams;
  use standard-io;
end module cat;
