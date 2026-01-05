#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pwd.h>
#include <grp.h>
#include <unistd.h>
#include <time.h>


void print_permissions(mode_t mode) {
    printf( (S_ISDIR(mode)) ? "d" : "-");
    printf( (mode & S_IRUSR) ? "r" : "-");
    printf( (mode & S_IWUSR) ? "w" : "-");
    printf( (mode & S_IXUSR) ? "x" : "-");
    printf( (mode & S_IRGRP) ? "r" : "-");
    printf( (mode & S_IWGRP) ? "w" : "-");
    printf( (mode & S_IXGRP) ? "x" : "-");
    printf( (mode & S_IROTH) ? "r" : "-");
    printf( (mode & S_IWOTH) ? "w" : "-");
    printf( (mode & S_IXOTH) ? "x" : "-");
}


void print_file_details(const char *path, const char *name) {
    char fullpath[1024];
    snprintf(fullpath, sizeof(fullpath), "%s/%s", path, name);

    struct stat sb;
    if (stat(fullpath, &sb) == -1) {
        perror("stat");
        return;
    }
        // Print file permissions
    print_permissions(sb.st_mode);
    printf(" ");

    // Number of hard links
    printf("%lu ", sb.st_nlink);

    // Owner username
    struct passwd *pw = getpwuid(sb.st_uid);
    if (pw)
        printf("%s ", pw->pw_name);
    else
        printf("%d ", sb.st_uid);

    // Group name
    struct group *gr = getgrgid(sb.st_gid);
    if (gr)
        printf("%s ", gr->gr_name);
    else
        printf("%d ", sb.st_gid);

    // Time format (like ls)
    char timebuf[64];
    struct tm *tm_info = localtime(&sb.st_mtime);
    strftime(timebuf, sizeof(timebuf), "%b %d %H:%M", tm_info);

    printf("%s ", timebuf);

    // File name
    printf("%s\n", name);

}

int main(int argc, char *argv[]) {
    int long_format = 0;
    char *dirpath = NULL;

   
    if (argc == 1) {
        dirpath = ".";
    } else if (argc == 2) {
        if (strcmp(argv[1], "-l") == 0)
            dirpath = ".";
        else
            dirpath = argv[1];
    } else if (argc == 3 && strcmp(argv[1], "-l") == 0) {
        long_format = 1;
        dirpath = argv[2];
    } else {
        fprintf(stderr, "Usage: %s [-l] [directory]\n", argv[0]);
        exit(1);
    }

    if (argc >= 2 && strcmp(argv[1], "-l") == 0)
        long_format = 1;

    DIR *dir = opendir(dirpath);
    if (!dir) {
        perror("opendir");
        return 1;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
          if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
            continue;

        if (long_format)
            print_file_details(dirpath, entry->d_name);
        else
            printf("%s\n", entry->d_name);
    }

    closedir(dir);
    return 0;
}

